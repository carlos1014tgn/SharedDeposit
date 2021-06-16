#pragma line
# @version ^0.2.0
#Contract Shared Deposit ! one contract per file
#Storage variables


struct contract:
    creator: address
    partner: address
    amount: uint256
    donation_percentage: decimal
    is_locked: bool
    destination: address

curr_id: uint256

hashmap: HashMap[uint256, contract]

contract_owner: address

@external
def __init__():
    self.contract_owner = msg.sender
    self.curr_id = 0

@external
@payable
def deposit(_partner: address, _donation: uint256) -> uint256:
    self.hashmap[self.curr_id].creator = msg.sender
    self.hashmap[self.curr_id].partner = _partner
    self.hashmap[self.curr_id].amount = self.hashmap[self.curr_id].amount + msg.value - _donation
    self.hashmap[self.curr_id].is_locked = True
    self.curr_id = self.curr_id + 1
    send(self.contract_owner, _donation)
    return self.curr_id - 1

@external
def unlock(_destination: address, contract_id: uint256):
    assert self.hashmap[contract_id].partner == msg.sender, "You are not the partner of the contract"
    assert self.hashmap[contract_id].is_locked == True, "Contract already unlocked"
    self.hashmap[contract_id].is_locked = False
    self.hashmap[contract_id].destination = _destination

@external
def withraw(_destination: address, contract_id: uint256):
    assert self.hashmap[contract_id].is_locked == False, "Contract is still locked"
    assert self.hashmap[contract_id].destination == _destination, "Destinations not matching"
    assert self.hashmap[contract_id].creator == msg.sender, "Only contract creator can withraw it"
    send(_destination, self.hashmap[contract_id].amount)
    self.hashmap[contract_id].amount = 0

@external
@view
def get_deposit_data(contract_id: uint256) -> uint256:
    return self.hashmap[contract_id].amount


