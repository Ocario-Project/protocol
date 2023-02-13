// SPDX-License-Identifier: Apache-2.0
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
pragma experimental ABIEncoderV2;

import "@0x/contracts-erc20/contracts/src/v06/IERC20TokenV06.sol";

/// @dev VIP Ocario fill functions.
interface IOcarioFeature {
    /// @dev Sell attached ETH directly against Ocario.
    /// @param encodedPath Uniswap-encoded path, where the first token is WETH.
    /// @param minBuyAmount Minimum amount of the last token in the path to buy.
    /// @param recipient The recipient of the bought tokens. Can be zero for sender.
    /// @return buyAmount Amount of the last token in the path bought.
    function sellEthForTokenToOcario(
        bytes memory encodedPath,
        uint256 minBuyAmount,
        address recipient
    ) external payable returns (uint256 buyAmount);

    /// @dev Sell a token for ETH directly against Ocario.
    /// @param encodedPath Uniswap-encoded path, where the last token is WETH.
    /// @param sellAmount amount of the first token in the path to sell.
    /// @param minBuyAmount Minimum amount of ETH to buy.
    /// @param recipient The recipient of the bought tokens. Can be zero for sender.
    /// @return buyAmount Amount of ETH bought.
    function sellTokenForEthToOcario(
        bytes memory encodedPath,
        uint256 sellAmount,
        uint256 minBuyAmount,
        address payable recipient
    ) external returns (uint256 buyAmount);

    /// @dev Sell a token for another token directly against Ocario.
    /// @param encodedPath Uniswap-encoded path.
    /// @param sellAmount amount of the first token in the path to sell.
    /// @param minBuyAmount Minimum amount of the last token in the path to buy.
    /// @param recipient The recipient of the bought tokens. Can be zero for sender.
    /// @return buyAmount Amount of the last token in the path bought.
    function sellTokenForTokenToOcario(
        bytes memory encodedPath,
        uint256 sellAmount,
        uint256 minBuyAmount,
        address recipient
    ) external returns (uint256 buyAmount);

    /// @dev Sell a token for another token directly against Ocario.
    ///      Private variant, uses tokens held by `address(this)`.
    /// @param encodedPath Uniswap-encoded path.
    /// @param sellAmount amount of the first token in the path to sell.
    /// @param minBuyAmount Minimum amount of the last token in the path to buy.
    /// @param recipient The recipient of the bought tokens. Can be zero for sender.
    /// @return buyAmount Amount of the last token in the path bought.
    function _sellHeldTokenForTokenToOcario(
        bytes memory encodedPath,
        uint256 sellAmount,
        uint256 minBuyAmount,
        address recipient
    ) external returns (uint256 buyAmount);

    /// @dev The Ocario pool swap callback which pays the funds requested
    ///      by the caller/pool to the pool. Can only be called by a valid
    ///      Ocario pool.
    /// @param amount0Delta Token0 amount owed.
    /// @param amount1Delta Token1 amount owed.
    /// @param data Arbitrary data forwarded from swap() caller. An ABI-encoded
    ///        struct of: inputToken, outputToken, fee, payer
    function OcarioSwapCallback(int256 amount0Delta, int256 amount1Delta, bytes calldata data) external;
}