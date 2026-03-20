# Obolus Network Smart Contracts

Aiken (Plutus V3) smart contracts for the Obolus Network ecosystem.

- **Status:** Deployed (Preprod Testnet)
- **Framework:** [Aiken](https://aiken-lang.org)
- **Version:** 0.0.1

## 🚀 Deployment (Preprod)

| Validator | Status | Preprod Address | Deployment TX Hash |
| :--- | :--- | :--- | :--- |
| **Vault Core** | ✅ Deployed | `addr_test1wrfpdu6cpgfmyjd93z89j32avzzxvdnfkfs77zf0zl74wyck5cz93` | `53166ef468947ddd05cf90b0a32a837eb94318cbe719abd55f8022412da9b24d` |
| **Credit Engine** | ✅ Deployed | `addr_test1wrmmdhz2kq0mnkuk9ggqzlvrs8rxk4skvgtg7enf7ze3x5sp6uwlq` | `f693bc3e178b430eb7f0eab69584ebb383a27a9a0c17c20c72eb4b7a847efa10` |
| **vTokens Policy** | ✅ Deployed | `addr_test1wpkj6s3492gzvvx7x7xrhueg4thke2wqj2dak0zuggc6fyquc0cwr` | `e28dba1eeff5425249bb7ed148e57f96a163c3a73a2de293304dcc318e613623` |
| **Yield Router** | ✅ Deployed | `addr_test1wz9jlf9gnmvyt5gasx2svwz90auyyeatetvuke5ej6sjtsgamssl8` | `3183f556b01b8fa8e3927f0f55c0c19f6ff1c821dc92e496d2a76f19d1b0bcdd` |

## 🛠️ Components

- `lib/obolus/types.ak`: Shared protocol types.
- `lib/obolus/math.ak`: Fixed-point integer math for LTV and yield splitting.
- `validators/vault_core.ak`: Vault deposit/withdraw logic.
- `validators/credit_engine.ak`: Collateral and loan management.
- `validators/vtokens_policy.ak`: Minting policy for vUSDCx.
- `validators/yield_router.ak`: Yield distribution logic.

## 📦 Building

```bash
aiken build
aiken check
```

## 📜 License
MIT
