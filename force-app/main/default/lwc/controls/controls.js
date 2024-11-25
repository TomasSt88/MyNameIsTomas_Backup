import { LightningElement } from 'lwc';

export default class Controls extends LightningElement {
factors = [0,2,3,4,5,6,8,10,12,14,16,18,20];
devides = [0,2,3,4,5,6,8,10,12,14,16,18,20];
    handleAdd() {
    this.dispatchEvent(new CustomEvent('add'));
    }

    handleSubtract() {
        this.dispatchEvent(new CustomEvent('subtract'));
    }

    handleMultiply(event) {
        const factor = event.target.dataset.factor;
        this.dispatchEvent(new CustomEvent('multiply', {
          detail: factor
        }));
    }

    handleDevide(event) {
      const factor = event.target.dataset.factor; // Use 'factor' instead of 'devide'
      this.dispatchEvent(new CustomEvent('devide', {  // Use 'devide' event
        detail: factor
      }));
  }
}