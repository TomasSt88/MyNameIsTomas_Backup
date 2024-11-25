import { LightningElement, api } from 'lwc';

export default class Numerator extends LightningElement {

    _currentCount = 0;
    priorCount = 0;

    @api
    get counter() {
      return this._currentCount;
    }
    
    set counter(value) {
      this.priorCount = this._currentCount;
      this._currentCount = value;
    }

    handleIncrement() {
      this.counter++;
    }

    handleDecrement() {
      this.counter--;
    }

    handleMultiply(event) {
        const factor = event.detail;
        this.counter *= factor;
    }

    handleDevide(event) {
      const divideFactor = event.detail;
      if (divideFactor != 0) {
          this.counter /= divideFactor;
      } else {
          console.error('Cannot divide by zero');
      }
    }

    @api
    maximizeCounter(amount) {
      this.counter += amount;
    }
}