class VerificationMailer < ApplicationMailer
  def invitation(verification_case)
    @verification_case = verification_case
    @candidate = verification_case.candidate
    @organization = verification_case.organization
    @link = start_verification_url(token: verification_case.token, host: "localhost:3000")

    mail(
      to: @candidate.email,
      subject: "Background Verification Request - #{@organization.name}"
    )
  end
end
