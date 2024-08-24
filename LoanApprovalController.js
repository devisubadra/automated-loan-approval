// JavaScript controller for handling form submission and response
document.addEventListener('DOMContentLoaded', function() {
    var form = document.getElementById('loanApprovalForm');
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        
        // Collect form data
        var applicantId = document.getElementById('applicantId').value;
        var loanAmount = document.getElementById('loanAmount').value;
        
        // Perform validation if needed
        if (!applicantId || !loanAmount) {
            alert('Please fill in all fields.');
            return;
        }
        
        // Create XMLHttpRequest to send data to Salesforce controller
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/services/apexrest/LoanApproval/', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onload = function() {
            if (xhr.status === 200) {
                // Update result
                var result = JSON.parse(xhr.responseText);
                document.getElementById('result').innerText = 'Approval Status: ' + result.approvalStatus;
            } else {
                document.getElementById('result').innerText = 'Error: ' + xhr.statusText;
            }
        };
        xhr.send(JSON.stringify({
            applicantId: applicantId,
            loanAmount: loanAmount
        }));
    });
});
