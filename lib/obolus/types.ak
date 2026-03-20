pub type VaultDatum {
  owner: ByteArray,
  deposited_amount: Int,
  vtokens_minted: Int,
  deposit_slot: Int,
  strategy: ByteArray,
}

pub type CreditDatum {
  borrower: ByteArray,
  collateral_vtokens: Int,
  borrowed_amount: Int,
  borrow_slot: Int,
  ltv_bps: Int,
  repay_mode: ByteArray,
}

pub type YieldRouterDatum {
  vault_ref: ByteArray,
  pending_yield: Int,
  debt_portion_bps: Int,
}

pub type VaultAction {
  Deposit
  Withdraw { amount: Int }
  Harvest
}

pub type CreditAction {
  OpenCredit { ltv_bps: Int }
  Repay { amount: Int }
  Liquidate
}

pub type RouterAction {
  RouteYield
  UpdateDebtPortion { new_bps: Int }
}
