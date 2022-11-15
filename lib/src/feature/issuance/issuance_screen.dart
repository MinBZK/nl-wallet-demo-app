import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common/widget/centered_loading_indicator.dart';
import '../organization/approve_organization_page.dart';
import 'bloc/issuance_bloc.dart';
import 'page/proof_identity_page.dart';

class IssuanceScreen extends StatelessWidget {
  static String getArguments(RouteSettings settings) {
    final args = settings.arguments;
    try {
      return args as String;
    } catch (exception, stacktrace) {
      Fimber.e('Failed to decode $args', ex: exception, stacktrace: stacktrace);
      throw UnsupportedError('Make sure to pass in a (mock) id when opening the IssuanceScreen');
    }
  }

  const IssuanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      restorationId: 'issuance_scaffold',
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).issuanceScreenTitle),
        leading: _buildBackButton(context),
        actions: const [CloseButton()],
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(child: _buildPage()),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return BlocBuilder<IssuanceBloc, IssuanceState>(
      buildWhen: (prev, current) => prev.stepperProgress != current.stepperProgress,
      builder: (context, state) {
        return LinearProgressIndicator(value: state.stepperProgress);
      },
    );
  }

  Widget _buildPage() {
    return BlocBuilder<IssuanceBloc, IssuanceState>(
      builder: (context, state) {
        if (state is IssuanceInitial) return const CenteredLoadingIndicator();
        if (state is IssuanceLoadInProgress) return const CenteredLoadingIndicator();
        if (state is IssuanceCheckOrganization) return _buildCheckOrganizationPage(context, state);
        if (state is IssuanceProofIdentity) return _buildProofIdentityPage(context, state);
        if (state is IssuanceProvidePin) return Text(state.runtimeType.toString());
        if (state is IssuanceProvidePinSuccess) return Text(state.runtimeType.toString());
        if (state is IssuanceProvidePinFailure) return Text(state.runtimeType.toString());
        if (state is IssuanceCheckCardAttributes) return Text(state.runtimeType.toString());
        if (state is IssuanceCardAdded) return Text(state.runtimeType.toString());
        if (state is IssuanceStopped) return Text(state.runtimeType.toString());
        if (state is IssuanceGenericError) return Text(state.runtimeType.toString());
        if (state is IssuanceIdentityValidationFailure) return Text(state.runtimeType.toString());
        throw UnsupportedError('Unknown state: $state');
      },
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return BlocBuilder<IssuanceBloc, IssuanceState>(
      builder: (context, state) {
        if (state.canGoBack) {
          return BackButton(onPressed: () => context.read<IssuanceBloc>().add(const IssuanceBackPressed()));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildCheckOrganizationPage(BuildContext context, IssuanceCheckOrganization state) {
    return ApproveOrganizationPage(
      onDecline: () => context.read<IssuanceBloc>().add(const IssuanceOrganizationDeclined()),
      onAccept: () => context.read<IssuanceBloc>().add(const IssuanceOrganizationApproved()),
      organization: state.organization,
      purpose: ApprovalPurpose.issuance,
    );
  }

  Widget _buildProofIdentityPage(BuildContext context, IssuanceProofIdentity state) {
    return ProofIdentityPage(
      onDecline: () => context.read<IssuanceBloc>().add(const IssuanceShareRequestedAttributesDeclined()),
      onAccept: () => context.read<IssuanceBloc>().add(const IssuanceShareRequestedAttributesApproved()),
      organization: state.organization,
      attributes: state.requestedAttributes,
    );
  }
}
