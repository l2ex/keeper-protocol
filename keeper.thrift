// Version v0.2.1

namespace cl keeper.v0
namespace cpp keeper.v0
namespace csharp keeper.v0
namespace d keeper.v0
namespace dart keeper.v0
namespace java keeper.v0
namespace php keeper.v0
namespace perl keeper.v0
namespace haxe keeper.v0
namespace netcore keeper.v0
namespace js keeper.v0

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

  EOS = 210,
  JUNGLE = 211
  DUC = 212,

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
  1: i32        price,
  2: i32        quantity,
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
  3: i32        price,
  4: i32        origQty,
  5: i32        executedQty,
  6: i32        cummulativeQuoteQty,
  10: i32       stopPrice,
  11: i32       icebergQty,
  12: i32       timestamp,
  13: i32       updateTime,
  15: bool      isWorking
}
struct ChannelStateResponse {
  1: Coin       coin,
  2: Chain      blockchain,
  3: i32        available,
  4: i32        balance,
  5: i32        total,
  6: i32        withdrawable,
  7: i32        nonce,
  8: i32        expiration
}
struct ChainStateResponse {
  1: Chain      blockchain,
  2: list<Coin> channels,
  3: list<Coin> coins,
  4: Address    signer,
  5: map<string, string> meta
}
struct CoinDetailsResponse {
  1: Chain      chain,
  2: Coin       coin,
  3: i8         decimals
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
  4: i32        price,
  5: i32        quantity,
  6: i32        quoteQuantity,
  7: i32        fee,
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

  list<CoinDetailsResponse> coins(),
  list<ChainStateResponse> chains(),
  
  list<ChannelStateResponse> channels(),
  ChannelStateResponse channel(1: Coin coin)

  OrderResponse new_order(1: OrderCreationRequest request),
  OrderResponse query_order(1: OrderQueryRequest request),
  OrderResponse cancel_order(1: OrderCreationRequest request),
  list<OrderResponse> get_orders(1: OrdersListRequest request),

  list<TradeResponse> get_trades(1: TradeListRequest request)
}