import { LightningElement } from 'lwc';
import authenticateApiKey from '@salesforce/apex/ApiKeyController.authenticateApiKey';

export default class ApiKeyAuth extends LightningElement {
    apiKey = '';
    errorMessage = '';

    handleApiKeyChange(event) {
        this.apiKey = event.target.value;
    }

    handleAuthenticate() {
        authenticateApiKey({ apiKey: this.apiKey })
            .then(result => {
                if (result) {
                    // Successful authentication, redirect or show success message
                    this.errorMessage = '';
                    // Perform necessary actions on success
                } else {
                    this.errorMessage = 'Invalid API Key. Please try again.';
                }
            })
            .catch(error => {
                console.error(error);
                this.errorMessage = 'Error while authenticating. Please contact support.';
            });
    }
}
