function showData() {
    fetch('https://fakerestapi.azurewebsites.net/api/v1/Users/')
        .then(response => response.json())
        //.then(json => console.log(json))
        .then(function (d) {
            let tbody_data = document.querySelector("tbody")
            tbody_data.innerHTML = ""
            let x = d.length;
            for (let i = 0; i < x; i++) {
                tbody_data.innerHTML += `<tr>
                                <td> ${d[i].id} </td>
                                <td> ${d[i].userName} </td>
                                <td> ${d[i].password} </td>
                            </tr>`
            }

        })
}
