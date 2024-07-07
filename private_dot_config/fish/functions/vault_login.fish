function vault_login --description "login to vault"
    set env $argv[1]
    switch $env
        case dev stg live
            echo "logging into $env vault"
        case '*'
            echo must specify valid environment
            return 1
    end

    cloudflared access login $env-vault.singularity6.io

    set VAULT_ADDR https://$env-vault.singularity6.io/
    set -Ux CF_TOKEN $(cloudflared access token -app https://$env-vault.singularity6.io)
    vault login -method=oidc --header "cf-access-token=$CF_TOKEN"
end
