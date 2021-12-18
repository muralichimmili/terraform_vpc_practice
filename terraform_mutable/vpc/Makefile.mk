help:
	@IFS=$$'\n' ; \
        help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
        for help_line in $${help_lines[@]}; do \
            IFS=$$'#' ; \
            help_split=($$help_line) ; \
            help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
            help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
            printf "%-15s %s\n" $$help_command $$help_info ; \
        done

clean:
    rm -rf .terraform

dev-apply: clean ## create dev environment
        @terraform init -backend-config=env/backend-dev.tfvars
        @terraform apply -auto-approve -var-file=env/dev.tfvars

prod-apply: clean ## create prod environment
        @terraform init -backend-config=env/backend-prod.tfvars
        @terraform apply -auto-approve -var-file=env/prod.tfvars

dev-destroy: clean ## destroy dev environment
        @terraform init -backend-config=env/backend-dev.tfvars
        @terraform destroy -auto-approve -var-file=env/dev.tfvars

prod-destroy: clean ## create prod environment
        @terraform init -backend-config=env/backend-prod.tfvars
        @terraform destroy -auto-approve -var-file=env/prod.tfvars