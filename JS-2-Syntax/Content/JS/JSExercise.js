
// Problem 1 - multiply numeric properties

let menu = {
    width: 200,
    height: 300,
    title: "My Menu"
}

function multiplyNumeric(menu) {
    for (var i in menu) {
        if (menu.hasOwnProperty(i)) {
            if (Number.isInteger(menu[i])) {
                menu[i] *= 2
            } else {
                console.log(i.toString() + "is not a valid property name")
            }
        }
    }
}

console.log(menu)
multiplyNumeric(menu)
console.log(menu)

// Problem 2 - email pattern matching

let email = ["franklyan94@gmail.com", "franklyan94gmail.com", "franklyan94gmail.@com"]

function checkEmailId(str) {
    const email_re = /\S+@\S+\.\S+/
    //const email_re = /\A[A-Z0-9+_.-]+@[A-Z0-9.-]+\Z/
    //const email_re = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$./
    if (str.search(email_re) == -1) return false;
    return true;
}

for (let i = 0; i < email.length; i++) {
    console.log(i + "th string is an email address?" + checkEmailId(email[i]))
}

// Problem 3 - truncate string

let strArray = ["franklyan94@gmail.comfranklyan94@gmail.comfranklyan94@gmail.com", "franklyan94@gmail.comfranklyan94@gmail.com", "franklyan94@gmail.com"]

function truncate(str, maxLength) {
    if (str.length > maxLength) {
        return str.slice(0, maxLength) + "..."
    }
    return str
}

for (let i = 0; i < strArray.length; i++) {
    console.log(strArray[i])
    console.log(truncate(strArray[i], 20))
}

// Problem 4 - array operations

// -- 1 --

let names = ["James", "Bernie"]

// -- 2 --

names.push("Robert")

// -- 3 --

if (names.length % 2 == 1) {
    names[Math.floor(names.length / 2)] = "Calvin"
}

console.log(names)

// -- 4 --

console.log(names.pop())

// -- 5 --

names.unshift("Rose", "Regal")

console.log(names)

// Problem 5 - swipe or touch

function validateCards(cardsToValidate, bannedPrefixes) {

    let validatedCards = []
    let cardLength = cardsToValidate[0].length
    
    for (let i = 0; i < cardsToValidate.length; i++) {
        let card = new Object()
        card["card"] = cardsToValidate[i]
        card["isAllowed"] = true
        cardString = card["card"].toString()
        for (let j = 0; j < bannedPrefixes; j++) {
            if (cardString.startsWith(bannedPrefixes)) {
                card["isAllowed"] = false
                break
            }
        }
        let sum = 0
        for (let j = 0; j < cardLength - 1; j++) {
            sum += parseInt(card["card"][j]) * 2
        }
        if (sum % 10 == parseInt(card["card"][cardLength - 1])) {
            card["isValid"] = true
        } else {
            card["isValid"] = false
        }
        validatedCards.push(card)
    }
    return JSON.stringify(validatedCards)
}

let cardsToValidate = [6724843711060148]
let bannedPrefixes = ["11", "3434", "67453", "9"]

console.log(validateCards(cardsToValidate, bannedPrefixes))

 Problem 6 - validate email address
//const email_re = /\S+@\S+\.\S+/

//function validateEmail(str) {
//    const email_re = /\S+@\S+\.\S+/
//    const email_re = /(\d_{0,1}){1,6}/
//    const email_re = /\A[A-Z0-9+_.-]+@[A-Z0-9.-]+\Z/
//    const email_re = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$./
//    if (str.search(email_re) == -1) return false;
//    return true;
//}