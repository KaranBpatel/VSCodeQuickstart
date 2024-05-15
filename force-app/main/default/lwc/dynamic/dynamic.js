import { LightningElement } from 'lwc';

export default class Dynamic extends LightningElement {


    componentConstructor;
    connectedCallback() {
        import("c/concreteComponent")
          .then(({ default: ctor }) => (this.componentConstructor = ctor))
          .catch((err) => console.log("Error importing component"));
      }
}