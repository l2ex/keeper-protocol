namespace cl keeper v0.1
namespace cpp keeper v0.1
namespace d keeper v0.1
namespace dart keeper v0.1
namespace java keeper v0.1
namespace php keeper v0.1
namespace perl keeper v0.1
namespace haxe keeper v0.1
namespace netcore keeper v0.1

enum OrderSide { 
  BUY = 1,
  SELL = 2
}

enum Pair {
  ETHUSDT = 1
}

enum Chain { 
  ETH = 1,
  EOS = 2,
  QTUM = 3,
  BTC = 99
}

enum Coin {
  ETH = 100,
  USDT = 101,
  OMG = 102

  EOS = 200,
  JUNGLE = 201
  DUC = 202,

  QTUM = 300,
  INK = 301,
  BODHI = 302,
  QBAO = 303
}

enum OrderType {
  LIMIT = 1,
  MARKET = 2
}

enum OrderStatus {
  NEW = 1,
  PARTIALLY_FILLED = 2,
  FILLED = 3,
  CANCELED = 4,
  REJECTED = 5,
  EXPIRED = 6
}

const i32 INT32CONSTANT = 9853
const map<string,Chain> MAPCONSTANT = {'ETH':1, 'EOS':2, 'QTUM': 3 }

typedef string Signature;
typedef string Id;
typedef string Nonce;
typedef string Address;
typedef string Hash;
typedef string BigNumber;

typedef Nonce AuthRequestLegacy;
struct AuthResponseLegacy {
  1: Signature  ethSignature,
  2: Signature  eosSignature,
  3: Signature  qtumSignature
}

struct SignRequestLegacy {
  1: string     blockchain,
  2: string     message
}
struct SignResponseLegacy {
  1: string     data,
  2: Signature  signature,
  3: Address    signer,
}
struct SignRequest {
  1: Chain      blockchain,
  2: binary     data 
}
struct SignResponse {
  1: Chain      blockchain,
  2: binary     data,
  3: Hash       hash,
  4: Signature  signature,
  5: Address    signer
}
struct OrderCreationRequest {
  1: BigNumber  price,
  2: BigNumber  quantity,
  3: OrderSide  side,
  4: Pair       symbol,
  5: Coin       quote,
  6: Coin       base,
  7: i32        timestamp,
  8: OrderType  type
}
struct OrderQueryRequest {
  1: Id id
}
struct OrderCancelRequest {
  1: Id id
}
struct OrderResponse {
  1: Pair       symbol,
  2: Id         id,
  7: OrderStatus status,
  8: OrderType  type,
  9: OrderSide  side,
  3: BigNumber  price,
  4: BigNumber  origQty,
  5: BigNumber  executedQty,
  6: BigNumber  cummulativeQuoteQty,
  10: BigNumber stopPrice,
  11: BigNumber icebergQty,
  12: i32       timestamp,
  13: i32       updateTime,
  15: bool      isWorking
}
struct ChannelStateResponse {
  1: Coin       coin,
  2: Chain      blockchain,
  3: BigNumber  available,
  4: BigNumber  balance,
  5: BigNumber  total,
  6: BigNumber  withdrawable,
  7: i32        nonce,
  8: BigNumber  expiration
}
struct ChainStateResponse {
  1: Chain      blockchain,
  2: list<Coin> channels,
  3: list<Coin> coins,
  4: Address    signer,
  5: map<string, string> meta
}
struct OrdersListRequest {
  1: i32        page = 0,
  2: i32        per_page = 50,
  3: bool       open_only
}
struct AuthRequest {
  1: Nonce nonce,
}
struct AuthResponse {
  1: Signature signature,
  2: map<Chain, Signature> chainSignatures
}
struct TradeListRequest {
  1: i32        page = 0,
  2: i32        per_page = 50,
}
struct TradeResponse {
  1: Pair       symbol,
  2: Id         id,
  3: Id         orderId,
  4: BigNumber  price,
  5: BigNumber  quantity,
  6: BigNumber  quoteQuantity,
  7: BigNumber  fee,
  8: Coin       feeCoin,
  9: i32        timestamp,
 10: bool       buyer, 
 11: bool       maker,
 12: bool       bestMatch
}

service KeeperLegacy {
  AuthResponseLegacy auth(1: AuthRequestLegacy request),
  SignResponseLegacy sign(1: SignRequestLegacy request)
}

service Keeper { 
  AuthResponse auth(1: AuthRequest request),
  SignResponse sign(1: SignRequest request),

  map<Chain, ChainStateResponse> chains(),
  map<Coin, ChannelStateResponse> channels(1: Chain chain),
  ChannelStateResponse channel(1: Coin coin)

  OrderResponse new_order(1: OrderCreationRequest request),
  OrderResponse query_order(1: OrderQueryRequest request),
  OrderResponse cancel_order(1: OrderCreationRequest request),
  list<OrderResponse> get_orders(1: OrdersListRequest request),

  list<TradeResponse> get_trades(1: TradeListRequest request)
}