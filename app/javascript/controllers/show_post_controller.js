import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["postForm", "postButton"];

  showForm() {
    const newPostMessage = "Create a New Post on Gembook";
    const hidePostMessage = "Hide New Post Form";
    console.log("hello this is the post controller!");
    this.postFormTarget.classList.toggle("hidden");
    this.postButtonTarget.textContent =  this.postButtonTarget.textContent === hidePostMessage ?  newPostMessage : hidePostMessage;
  }

  hideForm() {
    this.postFormTarget.classList.add("hidden");
  }
}
