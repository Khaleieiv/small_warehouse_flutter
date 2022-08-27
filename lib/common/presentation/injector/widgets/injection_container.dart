import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/auth/data/repositories/auth_repository.dart';
import 'package:small_warehouse/auth/presentation/state/auth_notifier.dart';
import 'package:small_warehouse/list_warehouse/data/repositories/warehouse_repository.dart';
import 'package:small_warehouse/list_warehouse/presentation/state/warehouse_notifier.dart';
import 'package:small_warehouse/rent/data/repositories/num_warehouse_repository.dart';
import 'package:small_warehouse/rent/data/repositories/rent_repository.dart';
import 'package:small_warehouse/rent/presentation/state/num_warehouse_notifier.dart';
import 'package:small_warehouse/rent/presentation/state/rent_state.dart';

class InjectionContainer extends StatefulWidget {
  final Widget child;

  const InjectionContainer({Key? key, required this.child}) : super(key: key);

  @override
  State<InjectionContainer> createState() => _InjectionContainerState();
}

class _InjectionContainerState extends State<InjectionContainer> {
  late final AuthNotifier _authNotifier;
  late final WarehouseNotifier _warehouseNotifier;
  late final NumWarehouseNotifier _numWarehousesNotifier;
  late final RentNotifier _rentNotifier;

  @override
  void initState() {
    final authRepository = AuthRepository();
    _authNotifier = AuthNotifier(
      authRepository,
    );

    final warehouseRepository = WarehouseListRepository();
    _warehouseNotifier = WarehouseNotifier(
      warehouseRepository,
    );

    final numWarehousesRepository = ListNumWarehousesRepository();
    _numWarehousesNotifier = NumWarehouseNotifier(
      numWarehousesRepository,
    );

    final rentRepository = RentWarehouseRepository();
    _rentNotifier = RentNotifier(
      rentRepository,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authNotifier),
        ChangeNotifierProvider.value(value: _warehouseNotifier),
        ChangeNotifierProvider.value(value: _numWarehousesNotifier),
        ChangeNotifierProvider.value(value: _rentNotifier),
      ],
      child: widget.child,
    );
  }
}
