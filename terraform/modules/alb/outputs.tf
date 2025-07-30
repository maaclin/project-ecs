
output "alb_sg" {
    value = aws_security_group.alb_sg.id
  
}

output "alb_target" {
    value = aws_lb_target_group.alb_target.arn
  
}

output "alb_listener" {
    value = aws_lb_listener.https.arn
  
}

output "alb_dns_name" {
    value = aws_lb.alb.dns_name
  
}

output "alb_zone_id" {
    value = aws_lb.alb.zone_id
  
}