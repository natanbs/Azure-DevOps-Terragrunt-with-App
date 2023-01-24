include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../../modules//rg"
}

locals {
  project_vars  = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars   = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  instance_vars = read_terragrunt_config(find_in_parent_folders("instance.hcl"))
}

inputs = {
  resource_group = "${local.env_vars.locals.env}${local.region_vars.locals.region_name}-${local.project_vars.locals.project}-${local.instance_vars.locals.instance}-rg"
  project        = local.project_vars.locals.project
  env            = local.env_vars.locals.env
  region         = local.region_vars.locals.region
  region_name    = local.region_vars.locals.region_name
  instance       = local.instance_vars.locals.instance
}
