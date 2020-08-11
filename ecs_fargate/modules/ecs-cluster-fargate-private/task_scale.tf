


resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_size
  min_capacity       = var.min_size
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.webapp-http.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy" {
    name               = "TargetALBConnScaling"
    policy_type        = "TargetTrackingScaling"
    resource_id        = aws_appautoscaling_target.ecs_target.resource_id
    scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
    service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

    target_tracking_scaling_policy_configuration{
        target_value = 2
        scale_in_cooldown = 30
        scale_out_cooldown = 30
        predefined_metric_specification {
            predefined_metric_type = "ALBRequestCountPerTarget"
            resource_label = "${aws_lb.fargate.arn_suffix}/${aws_lb_target_group.fargate.arn_suffix}"
        }
    }
  
}
