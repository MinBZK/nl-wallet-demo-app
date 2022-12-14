import '../../../domain/model/attribute/data_attribute.dart';
import '../../../domain/model/attribute/requested_attribute.dart';
import '../../../feature/verification/model/verification_request.dart';
import '../../../feature/verification/model/verifier_policy.dart';
import '../../source/organization_datasource.dart';
import 'verification_request_repository.dart';

class MockVerificationRequestRepository implements VerificationRequestRepository {
  final OrganizationDataSource organizationDataSource;

  MockVerificationRequestRepository(this.organizationDataSource);

  @override
  Future<VerificationRequest> getRequest(String sessionId) async {
    switch (sessionId) {
      case 'JOB_APPLICATION':
        return VerificationRequest(
          id: 'JOB_APPLICATION',
          organization: (await organizationDataSource.read('employer_1'))!,
          requestedAttributes: const [
            RequestedAttribute(
              name: 'Opleidingsnaam',
              type: AttributeType.education,
              valueType: AttributeValueType.text,
            ),
            RequestedAttribute(
              name: 'Onderwijsinstelling',
              type: AttributeType.university,
              valueType: AttributeValueType.text,
            ),
            RequestedAttribute(
              name: 'Niveau',
              type: AttributeType.educationLevel,
              valueType: AttributeValueType.text,
            ),
          ],
          policy: _kEmployerPolicy,
        );
      case 'MARKETPLACE_LOGIN':
        return VerificationRequest(
          id: 'MARKETPLACE_LOGIN',
          organization: (await organizationDataSource.read('marketplace'))!,
          requestedAttributes: const [
            RequestedAttribute(
              name: 'Voornamen',
              type: AttributeType.firstNames,
              valueType: AttributeValueType.text,
            ),
            RequestedAttribute(
              name: 'Achternaam',
              type: AttributeType.lastName,
              valueType: AttributeValueType.text,
            ),
            RequestedAttribute(
              name: 'Postcode',
              type: AttributeType.postalCode,
              valueType: AttributeValueType.text,
            ),
            RequestedAttribute(
              name: 'Woonplaats',
              type: AttributeType.city,
              valueType: AttributeValueType.text,
            ),
          ],
          policy: _kMockMarketPlacePolicy,
        );
      case 'BAR':
        return VerificationRequest(
          id: 'BAR',
          organization: (await organizationDataSource.read('bar'))!,
          requestedAttributes: const [
            RequestedAttribute(
              name: 'Pasfoto',
              type: AttributeType.profilePhoto,
              valueType: AttributeValueType.image,
            ),
            RequestedAttribute(
              name: 'Ouder dan 18',
              type: AttributeType.olderThan18,
              valueType: AttributeValueType.text,
            ),
          ],
          policy: _kMockBarPolicy,
        );
    }
    throw UnimplementedError('No mock usecase for id: $sessionId');
  }
}

const _kEmployerPolicy = VerifierPolicy(
  storageDuration: Duration(days: 3 * 30),
  dataPurpose: 'Gegevens controle',
  privacyPolicyUrl: 'https://www.example.org',
  deletionCanBeRequested: true,
  dataIsShared: false,
);

const _kMockMarketPlacePolicy = VerifierPolicy(
  storageDuration: Duration(days: 90),
  dataPurpose: 'Registreren',
  privacyPolicyUrl: 'https://www.example.org',
  deletionCanBeRequested: true,
  dataIsShared: false,
);

const _kMockBarPolicy = VerifierPolicy(
  storageDuration: Duration(days: 0),
  dataPurpose: 'Leeftijd controle',
  privacyPolicyUrl: 'https://www.example.org',
  deletionCanBeRequested: true,
  dataIsShared: false,
);
