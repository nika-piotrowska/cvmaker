/* eslint-disable no-promise-executor-return */
const submitSectionOnChange = (element) => {
  console.log('Mikotka to kawał kotka');
  const section = element.closest('#form-container');
  const submitButton = section.querySelector('#submit-button');
  submitButton.click();
};

window.submitSectionOnChange = submitSectionOnChange;

const assignOnChangeToTrix = () => {
  const trixInputs = document.querySelectorAll('trix-editor[class*="rich_text_area"]');
  trixInputs.forEach((input) => {
    const jqinput = $(input);
    jqinput.on('trix-blur', async function () {
      await new Promise((resolve) => setTimeout(resolve, 50));
      submitSectionOnChange(this);
      await new Promise((resolve) => setTimeout(resolve, 500));
    });
  });
};

window.assignOnChangeToTrix = assignOnChangeToTrix;
