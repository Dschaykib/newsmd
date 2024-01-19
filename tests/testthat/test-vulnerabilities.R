testthat::test_that("there are no known vulnerablities", {
  testthat::skip_on_cran()
  ## Tests specific versions
  audit_renv <- oysteR::audit_renv_lock(dir = dirname(renv::paths$lockfile()))
  testthat::expect_equal(sum(audit_renv$no_of_vulnerabilities), 0)

  ## Tests latest cran versions
  audit_latest <- oysteR::audit(
    pkg = audit_renv$package,
    version = rep("*", length(audit_renv$package)),
    type = "cran")
  testthat::expect_equal(sum(audit_latest$no_of_vulnerabilities), 0)

  ## Tests installed packages
  # there could be differences in the local usage
  audit_install <- oysteR::audit_installed_r_pkgs()
  testthat::expect_equal(sum(audit_install$no_of_vulnerabilities), 0)

})
