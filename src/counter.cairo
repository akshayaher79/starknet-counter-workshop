#[starknet::interface]
trait ICounter<TContractState> {
    fn increase_counter(ref self: TContractState);
    fn get_counter(self: @TContractState) -> u32;
}

#[starknet::contract]
pub mod counter_contract {
    use kill_switch::{ IKillSwitchDispatcher, IKillSwitchDispatcherTrait };
    use openzeppelin_access::ownable::OwnableComponent;

    component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);

    #[storage]
    struct Storage {
        counter: u32,
        kill_switch: starknet::ContractAddress,
        #[substorage(v0)]
        ownable: OwnableComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CounterIncreased: CounterIncreased,
        OwnableEvent: OwnableComponent::Event
    }

    #[derive(Drop, starknet::Event)]
    struct CounterIncreased {
        value: u32,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState, initial_value: u32,
        kill_switch: starknet::ContractAddress, initial_owner: starknet::ContractAddress
    ) {
        self.counter.write(initial_value);
        self.kill_switch.write(kill_switch);
        self.ownable.initializer(initial_owner);
    }
    
    #[abi(embed_v0)]
    impl OwnableImpl = OwnableComponent::OwnableImpl<ContractState>;

    impl OwnableInternalImpl = OwnableComponent::InternalImpl<ContractState>;

    #[abi(embed_v0)]
    impl Counter of super::ICounter<ContractState> {
        fn increase_counter(ref self: ContractState) {
            self.ownable.assert_only_owner();
            assert!(
                !IKillSwitchDispatcher { contract_address: self.kill_switch.read() }.is_active(),
                "Kill Switch is active"
            );

            self.counter.write(self.counter.read() + 1);
            self.emit(CounterIncreased { value: self.counter.read() });
        }

        fn get_counter(self: @ContractState) -> u32 {
            self.counter.read()
        }
    }
}