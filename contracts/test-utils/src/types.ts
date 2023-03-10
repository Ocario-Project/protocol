import { Order } from '@0x/types';
import { BigNumber } from '@0x/utils';
import { AbiDefinition } from 'ethereum-types';

export { OrderStatus } from '@0x/types';

export interface ERC20BalancesByOwner {
    [ownerAddress: string]: {
        [tokenAddress: string]: BigNumber;
    };
}

export interface EthBalancesByOwner {
    [owner: string]: BigNumber;
}

export interface SubmissionContractEventArgs {
    transactionId: BigNumber;
}

export interface BatchFillOrders {
    orders: Order[];
    signatures: string[];
    takerAssetFillAmounts: BigNumber[];
}

export interface MarketSellOrders {
    orders: Order[];
    signatures: string[];
    takerAssetFillAmount: BigNumber;
}

export interface MarketBuyOrders {
    orders: Order[];
    signatures: string[];
    makerAssetFillAmount: BigNumber;
}

export interface BatchCancelOrders {
    orders: Order[];
}

export interface CancelOrdersBefore {
    salt: BigNumber;
}

export interface TransactionDataParams {
    name: string;
    abi: AbiDefinition[];
    args: any[];
}

export interface MultiSigConfig {
    owners: string[];
    confirmationsRequired: number;
    secondsRequired: number;
}

export interface MultiSigConfigByNetwork {
    [networkName: string]: MultiSigConfig;
}

export interface Token {
    address?: string;
    name: string;
    symbol: string;
    decimals: number;
    ipfsHash: string;
    swarmHash: string;
}

export enum ContractName {
    TokenRegistry = 'TokenRegistry',
    MultiSigWalletWithTimeLock = 'MultiSigWalletWithTimeLock',
    Exchange = 'Exchange',
    DummyERC20Token = 'DummyERC20Token',
    EtherToken = 'WETH9',
    DutchAuction = 'DutchAuction',
    ZeroExGovernor = 'ZeroExGovernor',
    AccountLevels = 'AccountLevels',
    EtherDelta = 'EtherDelta',
    Arbitrage = 'Arbitrage',
    TestAssetDataDecoders = 'TestAssetDataDecoders',
    TestAssetProxyDispatcher = 'TestAssetProxyDispatcher',
    TestLibs = 'TestLibs',
    TestSignatureValidator = 'TestSignatureValidator',
    ERC20Proxy = 'ERC20Proxy',
    ERC721Proxy = 'ERC721Proxy',
    DummyERC721Receiver = 'DummyERC721Receiver',
    DummyERC721Token = 'DummyERC721Token',
    TestLibBytes = 'TestLibBytes',
    TestWallet = 'TestWallet',
    Whitelist = 'Whitelist',
    Forwarder = 'Forwarder',
    BalanceThresholdFilter = 'BalanceThresholdFilter',
}

export interface CancelOrder {
    order: Order;
    takerAssetCancelAmount: BigNumber;
}

export interface BatchMatchOrder {
    leftOrders: Order[];
    rightOrders: Order[];
    leftSignatures: string[];
    rightSignatures: string[];
}

export interface MatchOrder {
    left: Order;
    right: Order;
    leftSignature: string;
    rightSignature: string;
}

export interface TokenBalances {
    erc20: ERC20BalancesByOwner;
    eth: EthBalancesByOwner;
}

export interface FillEventArgs {
    orderHash: string;
    makerAddress: string;
    takerAddress: string;
    makerAssetFilledAmount: BigNumber;
    takerAssetFilledAmount: BigNumber;
    makerFeePaid: BigNumber;
    takerFeePaid: BigNumber;
}

export type Numberish = BigNumber | string | number;

export enum ExchangeFunctionName {
    BatchCancelOrders = 'batchCancelOrders',
    BatchExecuteTransactions = 'batchExecuteTransactions',
    BatchFillOrKillOrders = 'batchFillOrKillOrders',
    BatchFillOrders = 'batchFillOrders',
    BatchFillOrdersNoThrow = 'batchFillOrdersNoThrow',
    BatchMatchOrders = 'batchMatchOrders',
    BatchMatchOrdersWithMaximalFill = 'batchMatchOrdersWithMaximalFill',
    CancelOrder = 'cancelOrder',
    CancelOrdersUpTo = 'cancelOrdersUpTo',
    ExecuteTransaction = 'executeTransaction',
    FillOrKillOrder = 'fillOrKillOrder',
    FillOrder = 'fillOrder',
    FillOrderNoThrow = 'fillOrderNoThrow',
    MarketBuyOrdersNoThrow = 'marketBuyOrdersNoThrow',
    MarketSellOrdersNoThrow = 'marketSellOrdersNoThrow',
    MarketBuyOrdersFillOrKill = 'marketBuyOrdersFillOrKill',
    MarketSellOrdersFillOrKill = 'marketSellOrdersFillOrKill',
    MatchOrders = 'matchOrders',
    MatchOrdersWithMaximalFill = 'matchOrdersWithMaximalFill',
    PreSign = 'preSign',
    RegisterAssetProxy = 'registerAssetProxy',
    SetSignatureValidatorApproval = 'setSignatureValidatorApproval',
    SimulateDispatchTransferFromCalls = 'simulateDispatchTransferFromCalls',
    TransferOwnership = 'transferOwnership',
    SetProtocolFeeMultiplier = 'setProtocolFeeMultiplier',
    SetProtocolFeeCollectorAddress = 'setProtocolFeeCollectorAddress',
    DetachProtocolFeeCollector = 'detachProtocolFeeCollector',
}
