(() => {
  const fileSelect = document.getElementById('fileSelect');
  const fileInput = document.getElementById('fileInput');
  const browse = document.getElementById('browse');
  const table = document.getElementById('people');
  const tableBody = document.getElementById('people-body');
  const tableHeaderElements = document.getElementsByTagName('th');
  const peopleCount = document.getElementById('peopleCount');
  
  function resetSortStatus(elements) {
    for(let i = 0; i < elements.length; i++) {
      elements[i].removeAttribute('data-sorted');
      elements[i].removeAttribute('data-sorted-direction');
    }
  }

  function buildTdElem(type, value, image) {
    if(image) {
      return '<td class="i"><span class="' + type + '"></span>' + value + '</td>';
    } else {
      return '<td class="' + type + '">' + value + '</td>';
    }
  }

  function constructRows(values) {
    let trHTML = '';
    for(let value of values) {
      trHTML += '<tr>';
      trHTML += buildTdElem('last', value.last, false);
      trHTML += buildTdElem('first', value.first, false);
      if(value.m === 'None') {
        trHTML += buildTdElem('none', value.m, false);
      } else {
        trHTML += buildTdElem('m', value.m, false);
      }      
      trHTML += buildTdElem(value.pet.toLowerCase(), value.pet, true);
      trHTML += buildTdElem('birthday', value.birthday, false);
      trHTML += buildTdElem('color', value.color, false);
      trHTML += '</tr>';
    }
    return trHTML;
  }

  async function sendFileRequest(req) {
    return fetch(req)
    .then((res) => {
      if(res.ok) {
        let contentType = res.headers.get('Content-Type');
        if(contentType && contentType.includes('application/json')) {
          return res.json();
        } else {
          return Promise.reject('Unexpected Content-Type');
        }
      } else {
        return Promise.reject('Response not 200 - 299');
      }
    });
  }

  fileSelect.addEventListener('click', (e) => {
    if (fileSelect) {
      fileInput.click();
    }
  });

  browse.addEventListener('click', (e) => {
    if (fileInput) {
      fileInput.click();
    }
  });

  fileInput.addEventListener('change', async (e) => {
    e.preventDefault();
    let data = new FormData()
    data.append("csv", fileInput.files[0]);
    const req = new Request('/upload', {
      method: 'POST',
      body: data
    });

    // insert the name of the file last sent into the fileSelect element
    fileSelect.innerHTML = fileInput.files[0].name;
    fileInput.value = '';

    table.setAttribute('data-sortable-initialized', false);
    resetSortStatus(tableHeaderElements);

    sendFileRequest(req)
    .then((res) => {
      let trHTML = constructRows(res)
      tableBody.insertAdjacentHTML('beforeend', trHTML);
      Sortable.init();

      const rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr").length;
      peopleCount.innerHTML = rows;
    })
    .catch((e) => {
      console.log(e);
    });
  });
})();