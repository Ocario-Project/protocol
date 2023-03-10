/*

  Copyright 2023 ZeroEx Intl.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

pragma solidity ^0.6.5;

import "@0x/contracts-utils/contracts/src/v06/LibSafeMathV06.sol";
import "./IERC20TokenV06.sol";

contract MintableERC20TokenV06 is IERC20TokenV06 {
    using LibSafeMathV06 for uint256;

    uint8 public override decimals = 18;
    mapping(address => uint256) internal balances;
    mapping(address => mapping(address => uint256)) internal allowed;

    uint256 internal _totalSupply;

    /// @dev send `value` token to `to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return True if transfer was successful
    function transfer(address _to, uint256 _value) external override returns (bool) {
        require(balances[msg.sender] >= _value, "ERC20_INSUFFICIENT_BALANCE");
        require(balances[_to].safeAdd(_value) >= balances[_to], "UINT256_OVERFLOW");

        balances[msg.sender] = balances[msg.sender].safeSub(_value);
        balances[_to] = balances[_to].safeAdd(_value);

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    /// @dev send `value` token to `to` from `from` on the condition it is approved by `from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return True if transfer was successful
    function transferFrom(address _from, address _to, uint256 _value) external override returns (bool) {
        require(balances[_from] >= _value, "ERC20_INSUFFICIENT_BALANCE");
        require(allowed[_from][msg.sender] >= _value, "ERC20_INSUFFICIENT_ALLOWANCE");
        require(balances[_to].safeAdd(_value) >= balances[_to], "UINT256_OVERFLOW");

        balances[_to] = balances[_to].safeAdd(_value);
        balances[_from] = balances[_from].safeSub(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].safeSub(_value);

        emit Transfer(_from, _to, _value);

        return true;
    }

    /// @dev `msg.sender` approves `_spender` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of wei to be approved for transfer
    /// @return Always true if the call has enough gas to complete execution
    function approve(address _spender, uint256 _value) external override returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /// @dev Query total supply of token
    /// @return Total supply of token
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    /// @dev Query the balance of owner
    /// @param _owner The address from which the balance will be retrieved
    /// @return Balance of owner
    function balanceOf(address _owner) external view override returns (uint256) {
        return balances[_owner];
    }

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) external view override returns (uint256) {
        return allowed[_owner][_spender];
    }

    /// @dev Mints new tokens
    /// @param _to Address of the beneficiary that will own the minted token
    /// @param _value Amount of tokens to mint
    function _mint(address _to, uint256 _value) internal {
        balances[_to] = _value.safeAdd(balances[_to]);
        _totalSupply = _totalSupply.safeAdd(_value);

        emit Transfer(address(0), _to, _value);
    }

    /// @dev Mints new tokens
    /// @param _owner Owner of tokens that will be burned
    /// @param _value Amount of tokens to burn
    function _burn(address _owner, uint256 _value) internal {
        balances[_owner] = balances[_owner].safeSub(_value);
        _totalSupply = _totalSupply.safeSub(_value);

        emit Transfer(_owner, address(0), _value);
    }
}
