# prow-operator-test-harness

This is an example test harness meant for testing the prow operator addon. It does the following:

* Tests for the existence of the prowjobs.prow.k8s.io CRD. This should be present if the prow
  operator addon has been installed properly.
* Writes out a junit XML file with tests results to the /test-run-results directory as expected
  by the [https://github.com/openshift/osde2e](osde2e) test framework.
* Writes out an `addon-metadata.json` file which will also be consumed by the osde2e test framework.

## How to make it your test harness 
* Replace prow of your operator name
  * File name
  * Code in the files
* Change CRD 