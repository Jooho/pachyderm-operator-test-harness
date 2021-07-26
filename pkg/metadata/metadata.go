package metadata

import (
	"encoding/json"
	"io/ioutil"
	"os"
)

// metadata houses metadata to be written out to the additional-metadata.json
type metadata struct {
	// Whether the CRD was found. Typically Spyglass seems to have issues displaying non-strings, so
	// this will be written out as a string despite the native JSON boolean type.
	FoundCRD bool `json:"found-crd,string"`
	// Whether all pods are running status or not. 
	// Basically, operator expects all pods are running with a right situation.
	AllPodRunning bool `json:"all-pod-running,string"`
	// Check if job test specific for the isv operator succeed or not. 
	// This job task will be provided by ISV.
	SucceedJobTest bool `json:"succeed-job-test,string"`
}

// Instance is the singleton instance of metadata.
var Instance = metadata{}

// WriteToJSON will marshall the metadata struct and write it into the given file.
func (m *metadata) WriteToJSON(outputFilename string) (err error) {
	var data []byte
	if data, err = json.Marshal(m); err != nil {
		return err
	}

	if err = ioutil.WriteFile(outputFilename, data, os.FileMode(0644)); err != nil {
		return err
	}

	return nil
}
