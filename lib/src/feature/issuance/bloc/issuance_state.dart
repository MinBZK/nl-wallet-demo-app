part of 'issuance_bloc.dart';

abstract class IssuanceState extends Equatable {
  bool get canGoBack => false;

  double get stepperProgress => 0.0;

  const IssuanceState();
}

class IssuanceInitial extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceLoadInProgress extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceLoadFailure extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceCheckOrganization extends IssuanceState {
  final IssuanceResponse response;

  Organization get organization => response.organization;

  const IssuanceCheckOrganization(this.response);

  @override
  List<Object> get props => [organization];

  @override
  double get stepperProgress => 0.33;
}

class IssuanceProofIdentity extends IssuanceState {
  final IssuanceResponse response;

  Organization get organization => response.organization;

  List<DataAttribute> get requestedAttributes => response.requestedAttributes;

  const IssuanceProofIdentity(this.response);

  @override
  List<Object> get props => [response];

  @override
  bool get canGoBack => true;

  @override
  double get stepperProgress => 0.66;
}

class IssuanceProvidePin extends IssuanceState {
  final IssuanceResponse response;

  const IssuanceProvidePin(this.response);

  @override
  List<Object> get props => [response];

  @override
  bool get canGoBack => true;
}

class IssuanceProvidePinSuccess extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceProvidePinFailure extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceCheckCardAttributes extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceCardAdded extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceStopped extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceGenericError extends IssuanceState {
  @override
  List<Object> get props => [];
}

class IssuanceIdentityValidationFailure extends IssuanceState {
  @override
  List<Object> get props => [];
}
