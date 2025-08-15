// Disclaimer: The following code is based on the CS340 starter code for Web Application 
// Technology, with additions made to display the necessary table, information, and forms

import { useState, useEffect } from 'react';  // Importing useState for managing state in the component
import MemberTableRow from '../components/MemberTableRow';

function Members({ backendURL }) {

    // Set up a state variable `member` to store and display the backend response
    const [members, setMembers] = useState([]);


    const getData = async function () {
        try {
            // Make a GET request to the backend
            const response = await fetch(backendURL + '/members');
            
            // Convert the response into JSON format
            const {members} = await response.json();
    
            // Update the member state with the response data
            setMembers(members);
            
        } catch (error) {
          // If the API call fails, print the error to the console
          console.log(error);
        }

    };

    // Load table on page load
    useEffect(() => {
        getData();
    }, []);

    return (
        <>
            <h1>Members</h1>

            <table>
                <thead>
                    <tr>
                        {members.length > 0 && Object.keys(members[0]).map((header, index) => (
                            <th key={index}>{header}</th>
                        ))}
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    {members.map((members, index) => (
                        <MemberTableRow key={index} rowObject={members} backendURL={backendURL} refreshMembers={getData}/>
                    ))}

                </tbody>
            </table>
            
            {/*<CreateAuthorForm authors={authors} backendURL={backendURL} refreshAuthors={getData} />
            <UpdateAuthorForm authors={authors} backendURL={backendURL} refreshAuthors={getData} /> */}             
        </>
    );

} export default Members;