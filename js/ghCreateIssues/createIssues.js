const fetch = require('node-fetch');
require('dotenv').config();
const file = require('./issues.json');
const user = 'many-speech-analyses';
const repo = 'many_analyses';
const owner = 'stefanocoretta';

createIssueFromJSON = function(file) {
    file.forEach(issue => {
        fetch(`https://api.github.com/repos/${user}/${repo}/issues`, {
            method: 'post',
            owner: `${owner}`,
            body:    JSON.stringify(issue),
            headers: {'Accept': 'application/vnd.github.v3+json', 'Authorization': `token ${process.env.GITHUB_TOKEN}`}
        })
        .then(res => res.json())
        .then(json => {
            if (json.Status == 201) {
                console.log(`Issue created at ${json.status.Location}`)
            }
            else {
                console.log(`Something went wrong. Response: ${JSON.stringify(json)}`)
            }
        });
    })
}

createIssueFromJSON(file);
