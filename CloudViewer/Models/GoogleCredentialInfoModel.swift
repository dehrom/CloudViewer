import Foundation

struct GoogleCredentialInfoModel: Codable {
    let client_id: String
    let project_id: String
    let auth_uri: String
    let token_uri: String
    let auth_provider_x509_cert_url: String
    let client_secret: String
    let redirect_uris: [String]
}
