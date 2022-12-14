import '../../../data/repository/card/timeline_attribute_repository.dart';
import '../../../data/repository/card/wallet_card_repository.dart';
import '../../../data/repository/issuance/issuance_response_repository.dart';
import '../../../data/repository/wallet/wallet_repository.dart';
import '../../../data/source/organization_datasource.dart';
import '../../model/issuance_response.dart';
import '../../model/timeline_attribute.dart';

class SetupMockedWalletUseCase {
  final WalletRepository walletRepository;
  final WalletCardRepository walletCardRepository;
  final IssuanceResponseRepository issuanceResponseRepository;
  final TimelineAttributeRepository timelineAttributeRepository;
  final OrganizationDataSource organizationDataSource;

  SetupMockedWalletUseCase(
    this.walletRepository,
    this.walletCardRepository,
    this.issuanceResponseRepository,
    this.timelineAttributeRepository,
    this.organizationDataSource,
  );

  Future<void> invoke() async {
    // Create wallet
    await walletRepository.createWallet('000000');
    walletRepository.unlockWallet('000000');

    // Add PID card
    const cardId = 'PID_1';
    final IssuanceResponse issuanceResponse = await issuanceResponseRepository.read(cardId);
    final card = issuanceResponse.cards.first;
    walletCardRepository.create(card);

    // Add PID card; history
    timelineAttributeRepository.create(
      cardId,
      OperationAttribute(
        operationType: OperationType.issued,
        dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
        cardTitle: card.front.title,
        organization: (await organizationDataSource.read('rvig'))!,
        attributes: card.attributes,
      ),
    );
  }
}
