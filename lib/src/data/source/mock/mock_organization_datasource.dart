import 'package:collection/collection.dart';

import '../../../feature/verification/model/organization.dart';
import '../organization_datasource.dart';

class MockOrganizationDataSource implements OrganizationDataSource {
  @override
  Future<Organization?> read(String organizationId) async {
    return _kOrganizations.firstWhereOrNull((element) => element.id == organizationId);
  }
}

const _kOrganizations = [_kDuoOrganization, _kLotteryOrganization, _kRijksOrganization];

const _kDuoOrganization = Organization(
  id: 'duo',
  name: 'Dienst Uitvoering Onderwijs (DUO)',
  shortName: 'DUO',
  logoUrl: 'assets/non-free/images/logo_rijksoverheid.png',
  description:
      'Organisatie voor onderwijs en ontwikkeling in opdracht van het Nederlandse ministerie van Onderwijs, Cultuur en Wetenschap.',
);

const _kLotteryOrganization = Organization(
  id: 'staatsloterij',
  name: 'Nederlandse Staatsloterij',
  shortName: 'Staatsloterij',
  description:
      'Staatsloterij B.V. is een van de dochtervennootschappen van Nederlandse Loterij B.V.[1] De rechtsvoorganger Stichting Exploitatie Nederlandse Staatsloterij (SENS)[2] is in 1992 opgericht en heeft tot 2018 de Staatsloterij georganiseerd.',
  logoUrl: 'assets/non-free/images/logo_staatsloterij.png',
);

const _kRijksOrganization = Organization(
  id: 'rvig',
  name: 'Rijksdienst voor Identiteitsgegevens',
  shortName: 'RvIG',
  description: 'RvIG is de autoriteit en regisseur van het veilig en betrouwbaar gebruik van identiteitsgegevens',
  logoUrl: 'assets/non-free/images/logo_rijksoverheid.png',
);