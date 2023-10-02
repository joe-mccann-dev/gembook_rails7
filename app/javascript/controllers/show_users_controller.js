import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["friends", "users"]

  showFriends() {
    this.friendsTarget.classList.toggle("hidden");

  }

  showUsers(){
    this.usersTarget.classList.toggle("hidden");
  }
}