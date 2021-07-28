function showData() {
    fetch('https://fakerestapi.azurewebsites.net/api/v1/Books/')
        .then(response => response.json())
        //.then(json => console.log(json))
        .then(function (d) {
            let tbody_data = document.querySelector("tbody")
            tbody_data.innerHTML = ""
            let x = d.length;
            for (let i = 0; i < x; i++) {
                tbody_data.innerHTML += `<tr>
                                <td> ${d[i].id} </td>
                                <td> ${d[i].title} </td>
                                <td> ${d[i].publishDate} </td>
                                <td> ${d[i].pageCount} </td>
                                <td> ${d[i].excerpt.slice(0, 50)}... </td>
                                <td> ${d[i].description.slice(0, 50)}... </td>
                            </tr>`
            }

        })
}



