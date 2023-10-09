import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["postForm", "postButton"];

  showForm() {
    const newPostMessage = "Show Post Form";
    const hidePostMessage = "Hide Post Form";
    console.log("hello this is the post controller!");
    this.postFormTarget.classList.toggle("hidden");
    this.postButtonTarget.textContent =  this.postButtonTarget.textContent === hidePostMessage ?  newPostMessage : hidePostMessage;
  }

  hideForm() {
    this.postFormTarget.classList.add("hidden");
  }
}
