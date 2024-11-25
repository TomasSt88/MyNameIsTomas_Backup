import { LightningElement } from 'lwc';

export default class Augmentor extends LightningElement {

    startCounter = 0;
    
    handleStartChange(event) {
      this.startCounter = parseInt(event.target.value);
    }

    handleMaximizeCounter() {
        const amountToAdd = 1000000; // Change the value as needed
        this.template.querySelector('c-numerator').maximizeCounter(amountToAdd);
    }
}