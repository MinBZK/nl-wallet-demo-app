import '../../../data/repository/card/wallet_card_data_attribute_repository.dart';
import '../../../wallet_constants.dart';
import '../../model/data_attribute.dart';

class GetWalletCardDataAttributesUseCase {
  final WalletCardDataAttributeRepository dataAttributeRepository;

  GetWalletCardDataAttributesUseCase(this.dataAttributeRepository);

  Future<List<DataAttribute>> invoke(String cardId) async {
    await Future.delayed(kDefaultMockDelay);
    return dataAttributeRepository.getAll(cardId);
  }
}
