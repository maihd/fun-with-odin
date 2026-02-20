// This is generated file, DONOT EDIT!

package entities

Entity_Type :: enum {
    Entity_Bullet,
    Entity_Enemy,
    Entity_Player
}

Entity_Storage :: struct {
    entities: [Entity_Type][dynamic]Entity,
    // systems: [Entity_Type][dynamic]Entity_System,
}