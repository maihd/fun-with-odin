
// This is generated file, DONOT EDIT!

package entities

update_entities :: proc(storage: ^Entity_Storage) {
    {
        entities_0 := storage.entities[.Entity_Bullet]
        entities_1 := storage.entities[.Entity_Enemy]
        for entity_0 in entities_0 {
            for entity_1 in entities_1 {
                handle_enemy_bullet_collisions(transmute(^Entity_Bullet)entity_0, transmute(^Entity_Enemy)entity_1)
            }
        }
    }

    {
        entities_0 := storage.entities[.Entity_Player]
        entities_1 := storage.entities[.Entity_Enemy]
        for entity_0 in entities_0 {
            for entity_1 in entities_1 {
                handle_enemy_player_collisions(transmute(^Entity_Player)entity_0, transmute(^Entity_Enemy)entity_1)
            }
        }
    }
}
    