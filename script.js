document.addEventListener('DOMContentLoaded', function() {
    // Data for the chart
    const labels = ['January', 'February', 'March', 'April'];
    const dataValues = [65, 59, 80, 81];

    // Creating the chart
    const ctx = document.getElementById('myChart').getContext('2d');
    const chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Sample Data',
                data: dataValues,
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Data for the table
    const tableData = [
        { col1: 'Row 1 Col 1', col2: 'Row 1 Col 2' },
        { col1: 'Row 2 Col 1', col2: 'Row 2 Col 2' }
    ];

    // Populating the table
    const tableBody = document.querySelector('#dataTable tbody');
    tableData.forEach(row => {
        const tr = document.createElement('tr');
        const td1 = document.createElement('td');
        const td2 = document.createElement('td');
        
        td1.textContent = row.col1;
        td2.textContent = row.col2;
        
        tr.appendChild(td1);
        tr.appendChild(td2);
        tableBody.appendChild(tr);
    });
});