import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/auth/data/repositories/auth_repository.dart';
import 'package:small_warehouse/auth/presentation/state/auth_notifier.dart';
import 'package:small_warehouse/list_warehouse/data/repositories/warehouse_repository.dart';
import 'package:small_warehouse/list_warehouse/presentation/state/warehouse_notifier.dart';
import 'package:small_warehouse/rent/data/repositories/num_warehouse_repository.dart';
import 'package:small_warehouse/rent/presentation/state/num_warehouse_notifier.dart';

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

  @override
  void initState() {
    final warehouseRepository = WarehouseListRepository();
    _warehouseNotifier = WarehouseNotifier(
      warehouseRepository,
    );

    final numWarehousesRepository = ListNumWarehousesRepository();
    _numWarehousesNotifier = NumWarehouseNotifier(
      numWarehousesRepository,
    );

    final authRepository = AuthRepository();
    _authNotifier = AuthNotifier(
      authRepository,
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
      ],
      child: widget.child,
    );
  }
}
