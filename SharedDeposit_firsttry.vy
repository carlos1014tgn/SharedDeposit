#pragma line
# @version ^0.2.0
#Contract Shared Deposit ! one contract per file
#Storage variables
dev_address: public(address)
balance: public(uint256)
#Functions
@external
def __init__():
    # self.greet = concat(texts) we use self to reference external variables
    self.dev_address = 0xe77f0369f3C6C016E76D4d59dA3c0b40fCff344B


@external
@payable
def deposit(_amount: uint256, _partner: address, _donation_percentage: decimal):
    send(self.dev_address, _donation_percentage/100*msg.value)

@external
def withraw(_amount: uint256, _to: address):
    # Only the one depositing is allowed to withraw. Rest of users can only unlock
    assert 
    send(self.dev_address, _donation_percentage/100*msg.value)

@external
def unlock(_amount: uint256, _to: address):
    # Only the one depositing is allowed to withraw. Rest of users can only unlock
    assert 
    send(self.dev_address, _donation_percentage/100*msg.value)


@external # Can be called from outside the contract
@pure # Doesnt modify state variables

