/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author farajuhaimi
 */
public class User {
    private int userID;
    private String email;
    private String password;
    private String role;
   
    public User(int userID, String email, String password, String role) {
        this.userID = userID;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public User() {
        
    }

    // Getters and Setters
    public int getId() { 
        return userID; 
    }
    public void setId(int userID) { 
        this.userID = userID; 
    }
    
    public String getEmail() { 
        return email; 
    }
    public void setEmail(String email) { 
        this.email = email;
    }
     public String getPassword() { 
        return password;
    }
    public void setPassword(String password) { 
        this.password = password; 
    }
    public String getRole() { 
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
}
