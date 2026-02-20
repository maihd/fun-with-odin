package entities

Entity :: struct {
    type: Entity_Type,
    x, y: f32,
    scale_x, scale_y: f32,
    rotation: f32
}

@entity
Entity_Bullet :: struct {
    using base: Entity,
}

@entity
Entity_Enemy :: struct {
    using base: Entity,
}

@entity
Entity_Player :: struct {
    using base: Entity,
}