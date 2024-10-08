const { exec } = require('child_process');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Prompt for the website domain
rl.question('Please enter the website domain (e.g., example.com): ', (domain) => {
    // Execute the shell script with the provided domain
    exec(`sh get_website_age.sh ${domain}`, (error, stdout, stderr) => {
        // Check for execution errors
        if (error) {
            console.error(`Error executing script: ${error.message}`);
            return;
        }

        // Check for script errors
        if (stderr) {
            console.error(`Script error: ${stderr}`);
            return;
        }

        // Print the output from the script
        console.log(stdout);

        // Check if the output indicates success
        if (stdout.includes("Website information has been saved to")) {
            console.log("Success! The website age information has been exported.");
        }
    });

    // Close the readline interface
    rl.close();
});
