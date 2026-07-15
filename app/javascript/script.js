import Raty from "raty-js"

const initializeRatingInput = () => {
  const ratingInputElement = document.querySelector("[data-rating-input]")

  if (!ratingInputElement || ratingInputElement.dataset.ratyInitialized === "true") {
    return
  }

  const scoreValue = Number(ratingInputElement.dataset.ratingScore || 0)

  new Raty(ratingInputElement, {
    path: "",
    score: scoreValue,
    scoreName: ratingInputElement.dataset.ratingScoreName,
    starOn: ratingInputElement.dataset.ratingStarOn,
    starOff: ratingInputElement.dataset.ratingStarOff,
    starHalf: ratingInputElement.dataset.ratingStarHalf,
    hints: ["1", "2", "3", "4", "5"]
  }).init()

  ratingInputElement.dataset.ratyInitialized = "true"
}

const initializeRatingDisplays = () => {
  const ratingDisplayElements = document.querySelectorAll("[data-rating-display]")

  ratingDisplayElements.forEach((ratingDisplayElement) => {
    if (ratingDisplayElement.dataset.ratyInitialized === "true") {
      return
    }

    const scoreValue = Number(ratingDisplayElement.dataset.ratingScore || 0)

    new Raty(ratingDisplayElement, {
      path: "",
      readOnly: true,
      score: scoreValue,
      starOn: ratingDisplayElement.dataset.ratingStarOn,
      starOff: ratingDisplayElement.dataset.ratingStarOff,
      starHalf: ratingDisplayElement.dataset.ratingStarHalf
    }).init()

    ratingDisplayElement.dataset.ratyInitialized = "true"
  })
}

const initializeRaty = () => {
  initializeRatingInput()
  initializeRatingDisplays()
}

document.addEventListener("turbo:load", initializeRaty)