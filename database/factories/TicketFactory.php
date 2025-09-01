<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class TicketFactory extends Factory
{
    public function definition(): array
    {
        $statuses = ['open', 'pending', 'resolved'];
        $categories = ['Billing', 'Technical', 'Feature Request', 'General Inquiry'];
        
        return [
            'id' => (string) \Illuminate\Support\Str::ulid(),
            'subject' => $this->faker->sentence(),
            'body' => $this->faker->paragraphs(3, true),
            'status' => $this->faker->randomElement($statuses),
            'category' => $this->faker->randomElement($categories),
            'explanation' => $this->faker->sentence(),
            'confidence' => $this->faker->randomFloat(2, 0.5, 1.0),
            'note' => $this->faker->boolean(30) ? $this->faker->sentence() : null,
            'created_at' => $this->faker->dateTimeBetween('-30 days', 'now'),
        ];
    }
}