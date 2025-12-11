package com.codegnan.security;

import java.io.IOException;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtFilter extends OncePerRequestFilter {


private final JwtUtil jwtUtil;
private final UserDetailsService userDetailsService;


public JwtFilter(JwtUtil jwtUtil, UserDetailsService uds){
	this.jwtUtil = jwtUtil; 
	this.userDetailsService = uds;
	}


@Override
protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
        throws ServletException, IOException {

    String authHeader = request.getHeader("Authorization");
    String username = null;
    String token = null;

    try {
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            token = authHeader.substring(7);
            username = jwtUtil.extractUsername(token); // can throw errors
        }

        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {

            UserDetails ud = userDetailsService.loadUserByUsername(username);

            // IMPORTANT: Check if the token is valid
            if (jwtUtil.validateToken(token, ud)) {

                UsernamePasswordAuthenticationToken auth =
                        new UsernamePasswordAuthenticationToken(
                                ud,
                                null,
                                ud.getAuthorities()
                        );

                auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                SecurityContextHolder.getContext().setAuthentication(auth);
            }
        }

    } catch (Exception e) {
        System.out.println("JWT FILTER ERROR: " + e.getMessage());
        // do not stop the request, continue without authentication
    }

    filterChain.doFilter(request, response);
}
}