defmodule RecognitionWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
     otp_app: :recognition,
     module: RecognitionWeb.Auth.Guardian,
     error_handler: RecognitionWeb.Auth.GuardianErrorHandler

   plug Guardian.Plug.VerifySession
   plug Guardian.Plug.VerifyHeader
   plug Guardian.Plug.EnsureAuthenticated
   plug Guardian.Plug.LoadResource
end
