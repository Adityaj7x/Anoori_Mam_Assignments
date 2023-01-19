import { LightningElement, wire, track, api } from 'lwc';
import getCase from '@salesforce/apex/ApexClassforLwcDatatable.getCase';
import updateCase from '@salesforce/apex/ApexClassforLwcDatatable.updateCase';
import showComponentMethod from '@salesforce/apex/ApexClassforLwcDatatable.showComponentMethod';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class LwcDatatable extends LightningElement {
    @api recordId;
    @track onClickButtonLabel = 'Add ParentCase';
    @track error;
    @track part1 = true;
    @track part2 = false;
    showComponent;

    @wire(showComponentMethod, { recordIdMainCase: '$recordId' })
    ans(result) {
        if (result.data) {
            if (result.data === true) {
                this.showComponent = true;
            } else if (result.data === false) {
                this.showComponent = false;
            }
            console.log('this.showComponent: ' + this.showComponent);
        }
    }


    data = [];
    parentId;


    @wire(getCase, { recordIdCase: '$recordId' })
    cases({ error, data }) {
        if (data) {
            console.log('RecordId is:' + this.recordId);
            this.data = data;
            this.error = undefined;

        } else if (error) {
            console.log('Error block has been found');
            this.error = error;
            this.data = undefined;
        }
    }


    handleButtonClick(event) {
        const label = event.target.label;
        if (label === 'Add ParentCase') {
            this.onClickButtonLabel = 'Cancel';
            this.part2 = true;
            this.part1 = false;
        } else if (label === 'Cancel') {
            this.onClickButtonLabel = 'Add ParentCase';
            this.part2 = false;
            this.part1 = true;
        }
    }

    handleOnClickCase(event) {
        this.parentId = event.target.value;
        updateCase({ parentRecordIdCase: this.parentId, caseIdMain: this.recordId })
            .then(response => {
                //this.listCase = response;
                const evt = new ShowToastEvent({
                    title: 'Case has been Updated',
                    message: 'Parent Case Added sucessfully',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
                eval("$A.get('e.force:refreshView').fire();");
                this.showComponent = false;
            }).
            catch(error => {
                console.log('Error' + error.body.message);
            });

    }


}