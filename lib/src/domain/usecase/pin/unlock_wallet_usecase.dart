import '../../../data/repository/wallet/wallet_repository.dart';
import '../../../wallet_constants.dart';
import 'base_check_pin_usecase.dart';

class UnlockWalletUseCase extends CheckPinUseCase {
  final WalletRepository walletRepository;

  UnlockWalletUseCase(this.walletRepository);

  @override
  Future<bool> invoke(String pin) async {
    await Future.delayed(kDefaultMockDelay);
    walletRepository.unlockWallet(pin);
    return await walletRepository.isLockedStream.first == false;
  }
}
