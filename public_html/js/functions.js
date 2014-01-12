//	General Javascript Functions For IntegratedWeb.com.au
//	Copyright 2010 Integrated Web Services
//	-------------------------

function printPage(x) {
    var width = 740;
    var height = 550;
    window.open(x + '&view=print', 'Print', 'width=' + width + ',height=' + height + ',status=1,toolbar=1,location=0,resizable=1,scrollbars=1,menubar=0');
}

function likePage(x, y) {
    var width = 500;
    var height = 350;
    window.open('http://www.facebook.com/sharer.php?u=' + x + '&t=' + y, 'Share', 'width=' + width + ',height=' + height + ',status=1,toolbar=1,location=1,resizable=1,scrollbars=1,menubar=1');
}

function selectOption(optID, optNum, optTotal, optAttrName, optAttrValue) {
    
    var optionDiv = 0;
    for (var i = 1; i <= optTotal; i++) {
        if (optNum != i) {
            optionDiv = $(optID + 'Option' + i);
            optionDiv.className = 'select';
        }
    }
    optionDiv = $(optID + 'Option' + optNum);
    optionDiv.className = 'selectSelected';
    $(optAttrName).value = optAttrValue;
    $(optAttrName + 'Display').innerHTML = optAttrValue;
    $(optID + 'Option').value = optID + 'Option' + optNum;
    
}

function showDiv(x) {
    var d = document.getElementById(x);
    d.style.display = 'block';
}

function hideDiv(x) {
    var d = document.getElementById(x);
    d.style.display = 'none';
}

function submitForm(x) {
    var f = document.getElementById(x);
    f.submit;
}

function validateForm(x) {
    var form = document.getElementById(x);
    // Get the list of required form items
    var formItems = document.getElementById('requiredFields').value.split(",");
    // For each required form item, notify if empty
    for (var i=0, len=formItems.length; i<len; ++i ) {
        var inputInfo = formItems[i].split("::");
        var input = document.getElementById(inputInfo[0]);
        if (!input.value) {
            alert("You left a required field '" + inputInfo[1] + "' empty.");
            input.focus();
            return false;
        }
    }
    // Get the list of inputs that need to be formatted like an email address
    var validationItems = form.validateEmail.value.split(",");
    // For each item that needs to be validated like an email address
    for (var i=0, len=validationItems.length; i<len; ++i) {
        var inputInfo = validationItems[i].split("::");
        var input = document.getElementById(inputInfo[0]);
        if (!input.value.match(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+[a-zA-Z0-9]{2,4}$/)) {
            alert("You didn't enter a valid " + inputInfo[1] + ".");
            input.focus();
            return false;
        }
    }
    // No issues if we got this far, submit the form
    form.submit();
}
