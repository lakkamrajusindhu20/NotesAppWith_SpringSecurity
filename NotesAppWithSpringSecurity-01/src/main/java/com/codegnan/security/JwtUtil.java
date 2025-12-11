
package com.codegnan.security;


import java.security.Key;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

@Component
public class JwtUtil {


@Value("${jwt.secret}")
private String jwtSecret;


@Value("${jwt.expiration}")
private long jwtExpirationMs;


public String generateToken(String username){
Date now = new Date();
Date exp = new Date(now.getTime() + jwtExpirationMs);
Key key = Keys.hmacShaKeyFor(jwtSecret.getBytes());
return Jwts.builder().setSubject(username).setIssuedAt(now).setExpiration(exp).signWith(key).compact();
}


public String extractUsername(String token){
Key key = Keys.hmacShaKeyFor(jwtSecret.getBytes());
return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token).getBody().getSubject();
}
public boolean validateToken(String token, UserDetails userDetails) {
    String username = extractUsername(token);
    return (username.equals(userDetails.getUsername()) && !isTokenExpired(token));
}

private boolean isTokenExpired(String token) {
    return extractExpiration(token).before(new Date());
}

public Date extractExpiration(String token) {
    return extractAllClaims(token).getExpiration();
}

private Claims extractAllClaims(String token) {
    Key key = Keys.hmacShaKeyFor(jwtSecret.getBytes());
    return Jwts.parserBuilder()
            .setSigningKey(key)
            .build()
            .parseClaimsJws(token)
            .getBody();
}

}
